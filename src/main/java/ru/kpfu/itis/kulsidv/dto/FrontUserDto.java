package ru.kpfu.itis.kulsidv.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import ru.kpfu.itis.kulsidv.entity.Progress;
import ru.kpfu.itis.kulsidv.entity.Role;
import ru.kpfu.itis.kulsidv.entity.User;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@NoArgsConstructor
@Getter
@Setter
public class FrontUserDto {
    private Integer id;
    private String username;
    private Set<Role> roles;
    private List<Progress> progresses;

    public static FrontUserDto fromUser(User user){
        FrontUserDto dto = new FrontUserDto();
        dto.setId(user.getId());
        dto.setUsername(user.getUsername());
        dto.setRoles(user.getRoles());
        dto.setProgresses(user.getProgresses());
        return dto;
    }

    public User toUser(){
        User user = new User();
        user.setId(this.getId());
        user.setUsername(this.getUsername());
        user.setRoles(this.getRoles());
        user.setProgresses(this.getProgresses());
        return user;
    }
}
