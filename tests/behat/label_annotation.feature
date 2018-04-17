# This file is part of Moodle - http://moodle.org/
#
# Moodle is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Moodle is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Moodle.  If not, see <http://www.gnu.org/licenses/>.
#
# Tests for Ally filter forum annotations.
#
# @package    filter_ally
# @author     Guy Thomas
# @copyright  Copyright (c) 2018 Blackboard Inc.
# @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later


@filter @filter_ally
Feature: When the ally filter is enabled ally annotations are inserted when appropriate into user generated label content.

  Background:
    Given the ally filter is enabled

  @javascript
  Scenario: Label content is annotated and following HTML content URL for annotation works.
    Given the following "courses" exist:
      | fullname | shortname | category | format |
      | Course 1 | C1        | 0        | topics |
    And the following "users" exist:
      | username | firstname | lastname | email                |
      | student1 | Student   | 1        | student1@example.com |
      | teacher1 | Teacher   | 1        | teacher1@example.com |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | student1 | C1     | student        |
      | teacher1 | C1     | teacher        |
    And I log in as "teacher1"
    And I am on "Course 1" course homepage
    # Add padding to test viewport.
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    And I create a label with html content "<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br>" in section 1
    # Add label to check.
    And I create a label with html content "<p>Some content</p>" in section 5
    When I reload the page
    And I should see "Some content"
    And the label with html content "Some content" is not visible or not in viewport
    Then label with html "Some content" is annotated
    And I follow the webservice content url for label "Some content"
    And the label with html content "Some content" is visible and in viewport
    And I log out
    And I log in as "student1"
    And I am on "Course 1" course homepage
    And label with html "Some content" is annotated