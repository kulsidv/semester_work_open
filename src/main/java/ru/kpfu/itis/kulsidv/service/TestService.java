package ru.kpfu.itis.kulsidv.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.Test;
import ru.kpfu.itis.kulsidv.repository.ChapterRepository;
import ru.kpfu.itis.kulsidv.repository.TestRepository;

import java.util.List;
import java.util.Map;

@AllArgsConstructor
@Service
public class TestService {
    TestRepository testRepository;
    ChapterRepository chapterRepository;

    public void save(Test test) {
        Chapter chapter = chapterRepository.findById(test.getChapter().getId()).orElseThrow(() -> new EntityNotFoundException("Chapter not found"));
        test.setChapter(chapter);
        testRepository.save(test);
    }

    public List<Test> findAllByChapterId(Integer chapterId) {
        return testRepository.findAllByChapterId(chapterId);
    }

    public void delete(Test test) {
        testRepository.delete(test);
    }

    public boolean contains(Test test, List<Test> tests) {
        if (tests.isEmpty()) return false;
        for (Test t : tests) {
            if (test.getQuestion().equals(t.getQuestion()) && test.getAnswer().equals(t.getAnswer())) {
                return true;
            }
        }
        return false;
    }

    public Integer check(Map<Integer, String> test){
        int rights = 0;
        for (Map.Entry<Integer, String> entry : test.entrySet()) {
            Test t = testRepository.findById(entry.getKey()).orElse(null);
            if (t != null && t.getAnswer().equals(entry.getValue())) {
                rights++;
            }
        }
        return (int) ((double) rights / test.size() * 100);
    }
}
