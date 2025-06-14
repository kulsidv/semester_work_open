package ru.kpfu.itis.kulsidv.service;

import lombok.AllArgsConstructor;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import ru.kpfu.itis.kulsidv.dto.ChapterDto;
import ru.kpfu.itis.kulsidv.entity.Chapter;
import ru.kpfu.itis.kulsidv.entity.Paragraph;
import ru.kpfu.itis.kulsidv.entity.Test;
import ru.kpfu.itis.kulsidv.repository.ChapterRepository;

import java.util.List;

@AllArgsConstructor
@Service
public class ChapterService {
    private final ChapterRepository chapterRepository;
    private final ParagraphService paragraphService;
    private final TestService testService;

    public List<ChapterDto> findAll(){
        return chapterRepository.findAll(Sort.by(Sort.Order.asc("chapterNum"))).stream()
                .map(chapter -> new ChapterDto(
                        chapter.getId(),
                        chapter.getTitle(),
                        chapter.getChapterNum()
                ))
                .toList();
    }

    public Page<Chapter> findAll(Pageable pageable){
        return chapterRepository.findAll(pageable);
    }

    public Chapter findById(Integer id){
        Chapter chapter = chapterRepository.findById(id).orElse(null);
        if (chapter != null) {
            chapter.setParagraphs(paragraphService.findAllByChapterId(id));
            chapter.setTests(testService.findAllByChapterId(id));
        }
        return chapter;
    }

    public Chapter save(Chapter chapter){
        Chapter saved = chapterRepository.save(chapter);
        for (Paragraph paragraph : chapter.getParagraphs()) {
            paragraph.setChapter(saved);
            paragraphService.save(paragraph);
        }
        for (Test test : chapter.getTests()) {
            test.setChapter(saved);
            testService.save(test);
        }
        return saved;
    }

    public Chapter update(Chapter chapter){
        Chapter newChapter = new Chapter();
        List<Paragraph> currParagraphs = paragraphService.findAllByChapterId(chapter.getId());
        List<Test> currTests = testService.findAllByChapterId(chapter.getId());
        try {
            newChapter.setId(chapter.getId());
            newChapter.setTitle(chapter.getTitle());
            newChapter.setChapterNum(chapter.getChapterNum());
            for (Paragraph paragraph : chapter.getParagraphs()) {
                paragraph.setChapter(newChapter);
                paragraphService.save(paragraph);
            }
            for (Paragraph paragraph : currParagraphs) {
                if (!paragraphService.contains(paragraph, chapter.getParagraphs())) {
                    paragraphService.delete(paragraph);
                }
            }
            for (Test test : chapter.getTests()) {
                test.setChapter(newChapter);
                testService.save(test);
            }
            for (Test test : currTests) {
                if (!testService.contains(test, chapter.getTests())) {
                    testService.delete(test);
                }
            }
            return chapterRepository.save(newChapter);
        } catch(DataIntegrityViolationException e) {
            throw new DataIntegrityViolationException(e.getMessage());
        } catch (SecurityException e) {
            throw new SecurityException(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return newChapter;
    }

    public void delete(Integer id){
        chapterRepository.deleteById(id);
    }
}
