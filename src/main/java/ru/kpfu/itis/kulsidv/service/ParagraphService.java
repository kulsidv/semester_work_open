package ru.kpfu.itis.kulsidv.service;

import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.entity.Paragraph;
import ru.kpfu.itis.kulsidv.repository.ParagraphRepository;

import java.util.List;

@AllArgsConstructor
@Service
public class ParagraphService {
    private final ParagraphRepository paragraphRepository;

    public List<Paragraph> findAllByChapterId(Integer chapterId) {
        return paragraphRepository.findAllByChapterId(chapterId);
    }

    public void save(Paragraph paragraph) {
        paragraphRepository.save(paragraph);
    }

    public void delete(Paragraph paragraph) {
        paragraphRepository.delete(paragraph);
    }

    public boolean contains(Paragraph paragraph, List<Paragraph> paragraphs) {
        if (paragraphs.isEmpty()) return false;
        for (Paragraph p : paragraphs) {
            if (paragraph.getText().equals(p.getText())) {
                return true;
            }
        }
        return false;
    }
}
