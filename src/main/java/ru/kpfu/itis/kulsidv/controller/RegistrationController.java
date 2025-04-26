package ru.kpfu.itis.kulsidv.controller;

import org.springframework.dao.DataIntegrityViolationException;
//import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.service.UserService;

@Controller
public class RegistrationController {

    UserService userService;
    PasswordEncoder passwordEncoder;

    RegistrationController(UserService userService,
                           PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/registration")
    public String getRegistration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String postRegistration(@RequestParam("username") String username,
                                   @RequestParam("password") String password,
                                   @RequestParam("email") String email,
                                   Model model){
        //TODO: добавить валидацию через DTO и @Valid - для этого нужен Spring Boot
        try {
            System.out.println("Post is gotten");
            System.out.println("Username: " + username);
            System.out.println(userService.getClass());
            userService.save(new User(username, passwordEncoder.encode(password), email));
            System.out.println("Given to service save");
            return "reg-success";
        } catch (DataIntegrityViolationException e) {
            model.addAttribute("error", "username_exists");
            return "registration";
        } catch (Exception e) {
            model.addAttribute("error", "unknown_error");
            return "registration";
        }
    }
}
