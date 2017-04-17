@all @test2
Feature: test2 - Negative scenarios

  Background:
    Given create article and put random prefix in GLOBAL_HASH "t2_prefix_title"
    When click 'Edit' link related to title from GLOBAL_HASH "t2_prefix_title"

  @t2_s1
  Scenario Outline: 1.Create article with negative 'Title'

    Given visit address "localhost:3000/articles/new" with login "admin" and pass "admin"
    When fill 'Title' form with "<title>"
    When fill 'Text' form with "<text>"
    When click 'Create Article' button without wait
    Then verify text "<err_num> prohibited this article from being saved:" is present
    And error message is "<error_message>"

    Examples:
      | title | text  | err_num  | error_message                                |
      |       |       | 2 errors | Title can't be blank                         |
      |       |       | 2 errors | Title is too short (minimum is 5 characters) |
      |       | abcde | 2 errors | Title can't be blank                         |
      |       | abcde | 2 errors | Title is too short (minimum is 5 characters) |
      | abcd  | abcd  | 1 error  | Title is too short (minimum is 5 characters) |
      | a     | abcde | 1 error  | Title is too short (minimum is 5 characters) |


  @t2_s2
  Scenario Outline: 2.Update article with negative 'Title'
    When fill 'Title' form with "<title>"
    When fill 'Text' form with "<text>"
    When click 'Update Article' button without wait
    Then verify text "<err_num> prohibited this article from being saved:" is present
    And error message is "<error_message>"

    Examples:
      | title | text  | err_num  | error_message                                |
      |       |       | 2 errors | Title can't be blank                         |
      |       |       | 2 errors | Title is too short (minimum is 5 characters) |
      |       | abcde | 2 errors | Title can't be blank                         |
      |       | abcde | 2 errors | Title is too short (minimum is 5 characters) |
      | abcd  | abcd  | 1 error  | Title is too short (minimum is 5 characters) |
      | a     | abcde | 1 error  | Title is too short (minimum is 5 characters) |
