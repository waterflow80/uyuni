# Copyright (c) 2022-2024 SUSE LLC
# Licensed under the terms of the MIT license.

@slemicro54_minion
Feature: Migrate a SLE Micro 5.4 Salt minion to SLE Micro 5.5

  Scenario: Log in as admin user
    Given I am authorized for the "Admin" section

  # Having OS salt packages which are not up to date installed on the minion
  # will not allow it to undergo a Product migration
  Scenario: Remove OS salt leftovers from this SLE Micro 5.4 minion
    When I remove package "salt" from this "slemicro54_minion" without error control

  Scenario: Reboot this SLE Micro 5.4 minion and wait until reboot is completed
    Given I am on the Systems overview page of this "slemicro54_minion"
    When I follow first "Schedule System Reboot"
    Then I should see a "System Reboot Confirmation" text
    And I should see a "Reboot system" button
    When I click on "Reboot system"
    Then I should see a "Reboot scheduled for system" text
    When I wait at most 600 seconds until event "System reboot scheduled by admin" is completed
    Then I should see a "Reboot completed." text

  Scenario: Update Package List of this SLE Micro 5.4 minion
    Given I am on the Systems overview page of this "slemicro54_minion"
    And I follow "Software" in the content area
    And I click on "Update Package List"
    And I wait until event "Package List Refresh" is completed

  Scenario: Migrate this minion to SLE Micro 5.5
    Given I am on the Systems overview page of this "slemicro54_minion"
    When I follow "Software" in the content area
    And I follow "Product Migration" in the content area
    And I wait until I see "Target Products:" text, refreshing the page
    And I wait until I see "SUSE Linux Enterprise Micro 5.5 x86_64" text
    And I click on "Select Channels"
    And I check "allowVendorChange"
    And I click on "Schedule Migration"
    Then I should see a "Product Migration - Confirm" text
    When I click on "Confirm"
    Then I should see a "This system is scheduled to be migrated to" text

  Scenario: Check the migration is successful for this minion
    Given I am on the Systems overview page of this "slemicro54_minion"
    When I follow "Events"
    And I follow "History"
    And I wait at most 600 seconds until event "Product Migration" is completed
    And I wait until event "Package List Refresh" is completed
    And I reboot the "slemicro54_minion" minion through the web UI
    And I follow "Details" in the content area
    Then I wait until I see "SUSE Linux Enterprise Micro 5.5 x86_64" text, refreshing the page
    And vendor change should be enabled for product migration on "slemicro54_minion"

  Scenario: Install the latest Salt on this minion
    When I migrate the non-SUMA repositories on "slemicro54_minion"
    And I enable repositories before installing Salt on this "slemicro54_minion"
    And I install Salt packages from "slemicro54_minion"
    And I reboot the "slemicro54_minion" minion through the web UI
    And I disable repositories after installing Salt on this "slemicro54_minion"

  Scenario: Subscribe the SLE Micro minion to SLE Micro 5.5 child channels
    Given I am on the Systems overview page of this "slemicro54_minion"
    When I follow "Software" in the content area
    And I follow "Software Channels" in the content area
    And I wait until I do not see "Loading..." text
    And I should see the child channel "SLE-Manager-Tools-For-Micro5-Pool for x86_64 5.5" "unselected"
    When I select the child channel "SLE-Manager-Tools-For-Micro5-Pool for x86_64 5.5"
    Then I should see the child channel "SLE-Manager-Tools-For-Micro5-Pool for x86_64 5.5" "selected"
    And I click on "Next"
    Then I should see a "Confirm Software Channel Change" text
    When I click on "Confirm"
    Then I should see a "Changing the channels has been scheduled." text
    And I wait until event "Subscribe channels scheduled by admin" is completed

  # bsc#1085436 - Apache returns 403 Forbidden after a zypper refresh on minion
  Scenario: Check the new channel is working
    When I refresh the metadata for "slemicro54_minion"

  Scenario: Detect latest Salt changes on the SLE Micro minion
    When I query latest Salt changes on "slemicro54_minion"

  Scenario: Check events history for failures on the SLE Micro minion
    Given I am on the Systems overview page of this "slemicro54_minion"
    Then I check for failed events on history event page
