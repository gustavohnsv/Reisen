Feature: Acesso multiplataforma
  In order to continue following my travel plan even if I lose access to the original device
  As a viajante
  I want to be able to access my data from different devices

  Scenario: Acesso desde outro dispositivo
    Given there is a registered traveler with a saved plan
    When the traveler signs in from another device
    Then the traveler should see their saved plan
