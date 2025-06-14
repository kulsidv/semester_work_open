package ru.kpfu.itis.kulsidv.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.*;
import lombok.*;
import ru.kpfu.itis.kulsidv.entity.User;

import java.time.LocalDate;

@ToString
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class FormUserDto {

    Integer id;

    @NotBlank(message = "Username must be no empty.")
    @Size(min = 2, max = 30, message = "Username must be between 2 and 30 characters.")
    String username;

    @NotBlank(message = "Password has to be no empty.")
    @Size(min = 8, max = 32, message = "Password must be between 8 and 32 characters.")
    @Pattern(
            regexp = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).*$",
            message = "Password must contain minimum one uppercase letter, one lowercase letter, one digit and one special symbol."
    )
    String password;

    @Email(message = "Email must be valid.")
    String email;

    @JsonFormat(pattern = "yyyy-MM-dd")
    @Past
    LocalDate birthdate;

    String[] roles;

    //pict

    public static FormUserDto fromUser(User user){
        FormUserDto dto = new FormUserDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setEmail(user.getEmail());
        dto.setBirthdate(user.getBirthdate());
        dto.setPassword(user.getPassword());
        return dto;
    }

    public User toUser(){
        User user = new User();
        user.setUsername(this.username);
        user.setEmail(this.email);
        user.setBirthdate(this.birthdate);
        user.setPassword(this.password);
        user.setId(this.id);
        return user;
    }
}
