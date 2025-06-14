package ru.kpfu.itis.kulsidv.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.Progress;
import ru.kpfu.itis.kulsidv.entity.User;
import ru.kpfu.itis.kulsidv.repository.ProgressRepository;

import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
public class ProgressService {
    ProgressRepository progressRepository;
    ChapterService chapterService;
    TestService testService;

    public Integer save(Map<Integer, String> test, Integer chapterId, User user) {
        Chapter chapter = chapterService.findById(chapterId);
        Progress progress = progressRepository.findByUserAndChapter(user, chapter).orElse(new Progress());
        Integer result = testService.check(test);
        if (progress.getId() == null) {
            progress.setUser(user);
            progress.setChapter(chapter);
            progress.setTestResult(result);
        } else {
            if (progress.getTestResult() < result) progress.setTestResult(result);
            else return result;
        }
        progressRepository.save(progress);
        return result;
    }

    public void saveFirst(User user) {
        Progress progress = new Progress();
        progress.setUser(user);
        progress.setChapter(chapterService.findById(4));
        progress.setTestResult(100);
        progressRepository.save(progress);
    }

    public boolean containsFirst(Integer userId) {
        List<Progress> progresses = progressRepository.findAllByUserId(userId);
        return progresses.contains(progressRepository.findById(4).orElse(null));
    }
}
