@all @test1
Feature: test1 - Positive scenarios

  @t1_s1
  Scenario: 1.Article_smoke_test
# Smoke test
    Given visit main page with login "admin" and pass "admin"
    Then verify text "Hello, Rails!" is present
    When click 'My Blog' link
    Then verify text "Listing Articles" is present
    When click 'New article' link
    Then verify text "New article" is present
    When click 'Back' link
    Then verify text "Listing Articles" is present



  @t1_s2
  Scenario: 2.Article_CRUD
# Start New Article creation
    Given visit address "localhost:3000/articles/" with login "admin" and pass "admin"
    When click 'New article' link
    When generate random prefix number and put value in GLOBAL_HASH "t01_s2_prefix"
    When fill 'Title' form with prefix from GLOBAL_HASH "t01_s2_prefix"
    When fill 'Text' form with prefix from GLOBAL_HASH "t01_s2_prefix"
    When click 'Create Article' button
    Then verify that article created with prefix from GLOBAL_HASH "t01_s2_prefix"

# Update created article
    When click 'Edit' link related to title from GLOBAL_HASH "t01_s2_prefix"
    Then verify text "Edit article" is present
    When generate random prefix number and put value in GLOBAL_HASH "t01_s2_prefix_updated"
    When fill 'Title' form with prefix from GLOBAL_HASH "t01_s2_prefix_updated"
    When fill 'Text' form with prefix from GLOBAL_HASH "t01_s2_prefix_updated"
    When click 'Update Article' button
    When click 'Back' link
    Then verify that article updated with prefix from GLOBAL_HASH "t01_s2_prefix_updated"
    Then verify article absence with prefix from GLOBAL_HASH "t01_s2_prefix"

# Delete created article
    When click 'Destroy' link related to title from GLOBAL_HASH "t01_s2_prefix_updated"
    Then verify article absence with prefix from GLOBAL_HASH "t01_s2_prefix_updated"


  @t1_s3
  Scenario: 3.Comments_CRUD
    When create article and put random prefix in GLOBAL_HASH "t01_s3_prefix"

# Create a comment
    When click 'Show' link related to title from GLOBAL_HASH "t01_s3_prefix"
    Then verify text "Comments" is present
    When generate random prefix number and put value in GLOBAL_HASH "t01_s3_prefix_comment"
    When fill 'Commenter' form with prefix from GLOBAL_HASH "t01_s3_prefix_comment"
    When fill 'Body' form with prefix from GLOBAL_HASH "t01_s3_prefix_comment"
    When click 'Create Comment' button
    Then verify that comment created with prefix from GLOBAL_HASH "t01_s3_prefix_comment"

# Create second comment
    When create comment and put random prefix in GLOBAL_HASH "t01_s3_prefix_comment_2"

# Create third comment
    When create comment and put random prefix in GLOBAL_HASH "t01_s3_prefix_comment_3"

# Delete second comment
    When click 'Destroy Comment' link related to title from GLOBAL_HASH "t01_s3_prefix_comment_2"
    Then verify comment absence with prefix from GLOBAL_HASH "t01_s3_prefix_comment_2"

# Verify that article with comments is on the list
    Then verify that article created with prefix from GLOBAL_HASH "t01_s3_prefix"



  @t1_s4
  Scenario Outline: 4.Cases_Article_and_Comment_creation_update
# Start New Article creation
    Given visit address "localhost:3000/articles/" with login "admin" and pass "admin"
    When click 'New article' link
    When fill 'Title' form with "<title>"
    When fill 'Text' form with "<text>"
    When click 'Create Article' button without wait
    Then verify that article created with 'Title' "<title>" and 'Text' "<text>"

# Update created article
    When click 'Edit' link on article form
    When fill 'Title' form with "<upd_title>"
    When fill 'Text' form with "<upd_text>"
    When click 'Update Article' button
    Then verify that article created with 'Title' "<upd_title>" and 'Text' "<upd_text>"

# Create a comment
    When fill 'Commenter' form with "<commenter>"
    When fill 'Body' form with "<comment>"
    When click 'Create Comment' button
    Then verify that comment created with 'Commenter' "<commenter>" and 'Comment' "<comment>"

    When click 'Back' link
    Then verify article absence with 'Title' "<title>" and 'Text' "<text>" in list
    Then verify article presence with 'Title' "<upd_title>" and 'Text' "<upd_text>" in list

    Examples:
      | title     | text       | upd_title   | upd_text       | commenter   | comment |
      | 12345     | 465832     | 987654      |                |             |         |
      | 999999    | 1234sdf5   | 54321       |                |  zxcvb      | 1zxcvzx |
      | ojfoe     | 12sdf345   | 2dferdfrors | dfddfaaass     |  tyuiuyi    | 123456  |
      | !@#$%     | !@#$!#$    | !@#!@#      | !$#@!#@!#      |  !@#@!#     | !@#!@#  |
      | 00000     | 00000      | 111111      |  111111        |  0          | 0       |
      | POIIUTY   | FGHJKJ     | QOWIEU      |  BCNXMC        |  CMIKSSLS   | OWEIWC  |




