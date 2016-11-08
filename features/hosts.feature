Feature: Hosts can be added, deleted and shown dynamically by talking to heamons public API

    Scenario: No host has been added, then no host shall be returned by the API
        Given that I have started heamon
        When I get all hosts
        Then I get an empty list of hosts

    Scenario: Add a host and that host shall be returned by the API
        Given that I have started heamon
        When I add host
            | id   | hostname
            | test | a.test.com
        And I get all hosts
        Then I get the following host
            | id   | hostname
            | test | a.test.com

    Scenario: Add two hosts and those hosts shall be returned by the API
        Given that I have started heamon
        When I add hosts
            | id    | hostname
            | test  | a.test.com
            | test2 | b.test.com
        And I get all hosts
        Then I get the following hosts
            | id    | hostname
            | test  | a.test.com
            | test2 | b.test.com

    Scenario: Add one host two times and those hosts shall be returned by the API
        Given that I have started heamon
        When I add host
            | id   | hostname
            | test | a.test.com
        And I add host
            | id    | hostname
            | test2 | b.test.com
        And I get all hosts
        Then I get the following hosts
            | id    | hostname
            | test  | a.test.com
            | test2 | b.test.com

    Scenario: Add two hosts with the same hostname and both hosts shall be added and returned by the API
        Given that I have started heamon
        When I add hosts
            | id    | hostname
            | test  | a.test.com
            | test2 | a.test.com
        And I get all hosts
        Then I get the following hosts
            | id    | hostname
            | test  | a.test.com
            | test2 | a.test.com

    Scenario: Add one host and delete that host, no host shall be returned by the API
        Given that I have started heamon
        And I add host
            | id   | hostname
            | test | a.test.com
        When I delete host
            | id   |
            | test |
        And I get all hosts
        Then I get an empty list of hosts

    Scenario: Add one host and delete another host, the first host shall be returned by the API
        Given that I have started heamon
        And I add host
            | id   | hostname
            | test | a.test.com
        When I delete host
            | id           |
            | non-existing |
        And I get all hosts
        Then I get an empty list of hosts

    Scenario: Add two hosts and delete one, the other host shall be returned by the API
        Given that I have started heamon
        And I add hosts
            | id          | hostname
            | test        | a.test.com
            | test-delete | b.test.com
        When I delete host
            | id          |
            | test-delete |
        And I get all hosts
        Then I get the following hosts
            | id    | hostname
            | test  | a.test.com

    Scenario: Add two hosts and delete both, no host shall be returned by the API
        Given that I have started heamon
        And I add hosts
            | id          | hostname
            | test        | a.test.com
            | test-delete | b.test.com
        When I delete hosts
            | id          |
            | test        |
            | test-delete |
        And I get all hosts
        Then I get an empty list of hosts

    Scenario: Add two hosts and delete each one by one, no host shall be returned by the API
        Given that I have started heamon
        And I add hosts
            | id          | hostname
            | test        | a.test.com
            | test-delete | b.test.com
        When I delete host
            | id          |
            | test        |
        And I delete host
            | id          |
            | test-delete |
        And I get all hosts
        Then I get an empty list of hosts
