package com.vrs.dao.interfaces;

import java.util.List;

import com.vrs.model.User;

public interface UserDAO {

    boolean registerUser(User user);

    User getUserByEmail(String email);

    boolean emailExists(String email);

    boolean updateProfile(User user);

    boolean updatePassword(int userId, String password);

    boolean updateAccountStatus(int userId, String accountStatus);
    
    boolean deleteUserById(int userId);
    
    User getUserById(int userId);

    List<User> getAllUsers();
}