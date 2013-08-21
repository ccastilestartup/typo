Feature: Merge Articles
  As a blog administrator
  In order to merge articles
  I want to be able to merge two articles on my blog

  Background:
    Given the blog is set up

  Scenario: An admin should be able to successfully merge two distinct existing articles
    Given I am logged into the admin panel as admin
    And I am on the edit page for article with id 1
    When I fill in "merge_with" with "2"
    And I press "Merge"
    Then I should be on the read page for the merged article
    And the author of the merged article should be one of the authors of the original articles
    And the title of the merged article should be one of the titles of the original articles
    And the text should be the combined text from the two original articles
    And the comments from the original articles should all carry over to the new article

  Scenario: It should not be possible to merge an article that does not exist
    Given I am logged into the admin panel as admin
    And I am on the edit page for article with id 1
    When I fill in "merge_with" with "9"
    And I press "Merge"
    Then I should be on the edit page for article with id 1
    And I should see "Error, other article does not exist"

  Scenario: It should not be possible to merge the same article with itself
    Given I am logged into the admin panel as admin
    And I am on the edit page for article with id 1
    When I fill in "merge_with" with "1"
    And I press "Merge"
    Then I should be on the edit page for article with id 1
    And I should see "Error, cannot merge an article with itself"

  Scenario: A non-admin cannot merge articles
    Given I am logged into the admin panel not as admin
    And I am on the edit page for article with id 3
    Then I should not see "Merge"
    And I should not see "merge_with"
