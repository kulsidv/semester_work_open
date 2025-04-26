package ru.kpfu.itis.kulsidv.service;

import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;

    UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public void save(User user) {
        System.out.println("Gotten in service save");
        System.out.println(userRepository.saveAndFlush(user).getId());
        System.out.println(userRepository.findByUsername("test").toString());
        // if (userRepository.findByUsername(user.getUsername()).isEmpty()) {
        //} else {
        //    throw new DataIntegrityViolationException("Username already exists");
        //}
    }
}
