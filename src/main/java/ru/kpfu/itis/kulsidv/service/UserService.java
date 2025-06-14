package ru.kpfu.itis.kulsidv.service;

import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.dto.FormUserDto;
import ru.kpfu.itis.kulsidv.dto.FrontUserDto;
import ru.kpfu.itis.kulsidv.dto.VerifyDto;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.repository.ProgressRepository;
import ru.kpfu.itis.kulsidv.repository.RoleRepository;
import ru.kpfu.itis.kulsidv.repository.UserRepository;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

@AllArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final RoleRepository roleRepository;
    private final ProgressRepository progressRepository;
    private final MailService mailService;

    public Page<User> findAll(Pageable pageable){
        return userRepository.findAll(pageable);
    }

    public User findByIdWithProgress(Integer id){
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            user.setProgresses(progressRepository.findAllByUserId(id));
        }
        return user;
    }

    public User save(FormUserDto userDto) {
        try {
            User user = new User();
            user.setUsername(userDto.getUsername());
            user.setPassword(passwordEncoder.encode(userDto.getPassword()));
            user.setEmail(userDto.getEmail());
            user.setCreatedAt(LocalDate.now());

            Set<String> userRoles = new HashSet<>();
            if (userDto.getRoles() == null) {
                userRoles.add("ROLE_USER");
            } else {
                userRoles = Set.of(userDto.getRoles());
            }
            addRole(userRoles, user);

            return userRepository.save(user);
        } catch (DataIntegrityViolationException e) {
            throw new DataIntegrityViolationException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public FormUserDto update(Integer id, FormUserDto userDto, boolean isAdmin){
            User user = new User();
            User currentUser = userRepository.findById(id).orElseThrow(() -> new UsernameNotFoundException("User not found"));
            try {
                boolean valid;
                if (isAdmin) {
                    valid = true;
                } else {
                    valid = validateUser(userDto, currentUser);
                    String[] roles = new String[1];
                    roles[0] = "ROLE_USER";
                    userDto.setRoles(roles);
                }
                if (valid){
                    user.setId(id);
                    user.setUsername(userDto.getUsername());
                    user.setPassword(currentUser.getPassword());
                    user.setEmail(userDto.getEmail());
                    user.setBirthdate(userDto.getBirthdate());
                    user.setCreatedAt(currentUser.getCreatedAt());
                    addRole(Set.of(userDto.getRoles()), user);
                    userRepository.save(user);
                }
            } catch(DataIntegrityViolationException e) {
                throw new DataIntegrityViolationException(e.getMessage());
            } catch (SecurityException e) {
                throw new SecurityException(e.getMessage());
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        return FormUserDto.fromUser(user);
    }

    public FrontUserDto findById(Integer id) {
        return FrontUserDto.fromUser(userRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("Username not found")));
    }

    public void addRole(Set<String> roles, User user) throws Exception {
        for (String role : roles) {
            user.getRoles().add(roleRepository.findByName(role)
                    .orElseThrow(() -> new Exception("A such role does not exist")));
        }
    }

    public void delete(Integer userId){
        userRepository.deleteById(userId);
    }

    private boolean validateUser(FormUserDto user, User curr) throws SecurityException{
        if (!user.getUsername().equals(curr.getUsername()) && userRepository.existsByUsername(user.getUsername())) throw new SecurityException("Username already exists");
        if (!user.getEmail().equals(curr.getEmail()) && userRepository.existsByEmail(user.getEmail())) throw new SecurityException("Email already exists");
        if (!passwordEncoder.matches(user.getPassword(), curr.getPassword())) throw new SecurityException("Wrong password");
        return  true;
    }

    public User findProfileById(Integer id){
        return userRepository.findById(id).orElse(null);
    }

    public void sendVerificationCode(Integer userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new UsernameNotFoundException("User not found"));
        String verification = UUID.randomUUID().toString();
        user.setVerificationCode(verification);
        userRepository.save(user);
        mailService.sendSimpleEmail(user.getEmail(), "Подтверждение почты", "Вот Ваш код верификации: " + verification);
    }

    public boolean verify(VerifyDto dto) {
        User user = userRepository.findById(dto.userId()).orElse(null);
        if (user != null) {
            if (!user.getVerificationCode().equals(dto.code())) {
                delete(dto.userId());
                return false;
            }
            return true;
        }
        return false;
    }
}
