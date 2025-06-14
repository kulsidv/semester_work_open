package ru.kpfu.itis.kulsidv.controller;

import jakarta.validation.Valid;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import ru.kpfu.itis.kulsidv.dto.MessageDto;

@Controller
public class MessageController {

    @GetMapping("/chat")
    public String getChat(){
        return "chat";
    }

    @MessageMapping("/message")
    @SendTo("/topic/messages")
    public MessageDto handleMessage(@Valid MessageDto messageDto) {
        System.out.println(messageDto.getSender() + ": " + messageDto.getText());
        return messageDto;
    }
}