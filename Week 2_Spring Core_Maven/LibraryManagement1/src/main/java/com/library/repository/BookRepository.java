package com.library.repository;

import org.springframework.stereotype.Repository;

@Repository
public class BookRepository {

    public void performOperation() {
        System.out.println("Performing operation in BookRepository");
    }
}
