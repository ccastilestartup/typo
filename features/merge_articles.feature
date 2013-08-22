Feature: Merge Articles
  As a blog administrator
  In order to merge articles
  I want to be able to merge two articles on my blog

  Background:
    Given the blog is set up
    And there is exactly one article with title "Welcome to Typo!" and author "admin"
    And text of article "Welcome to Typo!" by "admin" is "Welcome to Typo. This is your first article. Edit or delete it, then start blogging!"
    And there is exactly one article with title "Words" and author "publisher"
    And text of article "Words" by "publisher" is "words, words, words"

  Scenario: An admin should be able to successfully merge two distinct existing articles
    Given I am logged into the admin panel as "admin"
    And I am on the edit page for the article written by "admin" with title "Welcome to Typo!"
    When I enter id of article written by "publisher" with title "Words" into "merge_with" field
    And I press "Merge"
    Then I should be on the preview page for the article written by "admin" with title "Welcome to Typo!"

  Scenario: When articles are merged, the merged article should contain the text of both previous articles
    Given I am logged into the admin panel as "admin"
    And I am on the edit page for the article written by "admin" with title "Welcome to Typo!"
    When I enter id of article written by "publisher" with title "Words" into "merge_with" field
    And I press "Merge"
    Then I should be on the preview page for the article written by "admin" with title "Welcome to Typo!"
    And the title of the article should be one of: "Welcome to Typo!" "Words"

  Scenario: It should not be possible to merge an article that does not exist
    Given I am logged into the admin panel as "admin"
    And I am on the edit page for the article written by "admin" with title "Welcome to Typo!"
    When I enter an id which does not match an existing article into "merge_with" field
    And I press "Merge"
    Then I should be on the edit page for the article written by "admin" with title "Welcome to Typo!"
    And I should see "Error, other article does not exist"

  Scenario: It should not be possible to merge the same article with itself
    Given I am logged into the admin panel as "admin"
    And I am on the edit page for the article written by "admin" with title "Welcome to Typo!"
    When I enter id of article written by "admin" with title "Welcome to Typo!" into "merge_with" field
    And I press "Merge"
    Then I should be on the edit page for the article written by "admin" with title "Welcome to Typo!"
    And I should see "Error, cannot merge an article with itself"

  Scenario: A non-admin cannot merge two articles
    Given I am logged into the admin panel as "publisher"
    And I am on the edit page for the article written by "publisher" with title "Words"
    Then I should not see "Merge"
    And I should not see "merge_with"