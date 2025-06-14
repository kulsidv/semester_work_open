package ru.kpfu.itis.kulsidv.service;

import lombok.AllArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.dto.FormUserDto;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.User;

@AllArgsConstructor
@Service
public class AdminService {
    private final ChapterService chapterService;
    private final UserService userService;

    public Page<Chapter> findAllChapters(Pageable pageable){
        return chapterService.findAll(pageable);
    }

    public Chapter findChapterById(Integer id){
        return chapterService.findById(id);
    }

    public Page<User> findAllUsers(Pageable pageable){
        return userService.findAll(pageable);
    }

    public User findUserById(Integer id){
        return userService.findByIdWithProgress(id);
    }

    public User saveUser(FormUserDto user){
        return userService.save(user);
    }

    public Chapter saveChapter(Chapter chapter){
        return chapterService.save(chapter);
    }

    public void updateUser(FormUserDto user, boolean isAdmin){
        userService.update(user.getId(), user, isAdmin);
    }

    public void deleteUser(Integer userId){
        userService.delete(userId);
    }

    public void updateChapter(Chapter chapter){chapterService.update(chapter);}

    public void deleteChapter(Integer chapterId) {chapterService.delete(chapterId);}
}
