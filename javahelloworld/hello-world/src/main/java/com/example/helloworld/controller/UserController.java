package com.example.helloworld.controller;

import com.example.helloworld.model.User;
import com.example.helloworld.repository.UserRepository;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/users")
public class UserController {

    private final UserRepository userRepository;

    public UserController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @GetMapping
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @PostMapping
    public User createUser(@RequestParam String name) {
        User user = new User(name);
        return userRepository.save(user);
    }
}
