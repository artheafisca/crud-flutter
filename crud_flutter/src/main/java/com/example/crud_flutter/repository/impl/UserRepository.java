package com.example.crud_flutter.repository.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.crud_flutter.model.User;
import com.example.crud_flutter.repository.IUserRepository;

@Repository
public class UserRepository implements IUserRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    @Override
    public User insertUser(User user) { 
        String query = "INSERT INTO tb_user (email, gender, name) VALUES (?, ?, ?)";
        jdbcTemplate.update(query, new Object[] {user.getEmail(), user.getGender(), user.getName()});

        return user;
    }

    @Override
    public User deleteUser(int id) {
        String query = "SELECT * FROM tb_user WHERE id = ?";
        var result = jdbcTemplate.queryForObject(query, new BeanPropertyRowMapper<>(User.class), id);

        query = "DELETE FROM tb_user WHERE id = ?";
        jdbcTemplate.update(query, id);

        return result;
    }

    @Override
    public List<User> getAllUser() {
        String query = "SELECT * FROM tb_user";

        return jdbcTemplate.query(query, new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public User updateUser(int id, User user) {
        String query = "UPDATE tb_user SET email = ?, gender = ?, name = ? WHERE id = ?";
        jdbcTemplate.update(query, new Object[] {user.getEmail(), user.getGender(), user.getName(), id});
        return user;
    }
    
}
