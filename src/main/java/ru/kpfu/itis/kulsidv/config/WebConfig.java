package ru.kpfu.itis.kulsidv.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;
import org.springframework.web.servlet.view.freemarker.FreeMarkerViewResolver;

@Configuration // говорит о том, что этот файл - конфигурация
@EnableWebMvc // разрешает проекту использовать mnc
@ComponentScan("ru.kpfu.itis.kulsidv") // говорит какую директорию сканировать для поиска бинов и аннотаций
public class WebConfig extends WebMvcConfigurationSupport {

    // это чтобы если у меня нет подходящего контроллера, управление от springmvc переходило к стандартному контейнеру сервлетов (вдруг у меня там есть самодельный сервлет?)
    @Override
    protected void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Bean
    public FreeMarkerConfigurer freeMarkerConfigurer() {
        // указывает ServletDispatcher в какой папке брать шаблоны для ViewResolver
        FreeMarkerConfigurer configurer = new FreeMarkerConfigurer();
        configurer.setTemplateLoaderPath("WEB-INF/views/");
        return configurer;
    }

    @Bean
    public FreeMarkerViewResolver viewResolver() {
        // сопоставляет строки с названием файла из контроллера с реальными файлами шаблонов
        FreeMarkerViewResolver resolver = new FreeMarkerViewResolver();
        resolver.setCache(false);
        resolver.setSuffix(".ftl");
        resolver.setPrefix("");
        resolver.setContentType("text/html;charset=UTF-8");
        return resolver;
    }
}
