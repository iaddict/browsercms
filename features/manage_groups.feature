Feature: Manage Groups
  CMS Admins should be able to create and manage groups and their permissions through the UI.

  Background:
    Given I am logged in as a Content Editor

  Scenario: Create a new content editor group
    Given I request /cms/groups
    Then I should see "List Groups"
    When I click on "Add Group"
    Then I should see a page titled "Add New Group"
    When I fill in "Name" with "Publisher's Group"
    And I select "CMS User" from "Type of User"
    And I check "Edit Content"
    And I check "Publish Content"
    And I check "My Site"
    And I press "Save"
    Then I should see "Publisher's Group"
    And the new group should have edit and publish permissions
    And I should see "1 of 2 Sections"

  Scenario: Create Public Group
    Given I request /cms/groups
    Then I should see "List Groups"
    When I click on "Add Group"
    Then I should see a page titled "Add New Group"
    When I fill in "Name" with "Authenticated Users"
    And I select "Registered Public User" from "Type of User"
    And I press "Save"
    Then I should see "Authenticated Users"
    Then I click on "Authenticated Users"
    And the new group should have neither edit nor publish permissions