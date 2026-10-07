// QuadrantFinder.swift
// Finds the quadrant or axis location of points entered by the user.
// Author: Abdul
// Date: 2026-10-06

import Foundation

enum InputError: Error {
    case invalidNumber
}

/// Reads coordinates, reports their location, and repeats when requested.
func main() {
    // Both coordinates use the same limits so points are checked consistently.
    let MIN_COORD = -1000.0
    let MAX_COORD = 1000.0

    // Welcome message
    print("Welcome to the Quadrant Finder!")
    print("Enter coordinates between -1000 and 1000.")

    // Initialize variables for the outer loop that checks for more points.
    var answer = ""
    var inputEnded = false

    // Find points until the user chooses to stop or the input stream ends.
    while !inputEnded && answer != "N" {
        var x = 0.0
        var xIsValid = false

        // Keep asking for X until it is in range or no more input is available.
        while !xIsValid && !inputEnded {
            print("Enter the X coordinate (-1000 to 1000):")

            if let input = readLine() {
                do {
                    guard let number = Double(input) else {
                        throw InputError.invalidNumber
                    }
                    x = number

                    // Accept X only when it falls between the stated minimum and maximum.
                    if x >= MIN_COORD && x <= MAX_COORD {
                        // A value in range is safe to use when classifying the point.
                        xIsValid = true
                    } else {
                        print("Out of range. Enter a number from -1000 to 1000.")
                    }
                } catch InputError.invalidNumber {
                    print("Invalid entry. Please enter a number, like 3 or -2.5.")
                } catch {
                    print("Unexpected input error: \(error)")
                }
            } else {
                // End-of-input stops coordinate validation and the outer point loop.
                inputEnded = true
            }
        }

        var y = 0.0
        var yIsValid = false

        // Only ask for Y when X is valid; both values are needed to locate the point.
        while xIsValid && !yIsValid && !inputEnded {
            print("Enter the Y coordinate (-1000 to 1000):")

            if let input = readLine() {
                do {
                    guard let number = Double(input) else {
                        throw InputError.invalidNumber
                    }
                    y = number

                    // Accept Y only when it falls between the stated minimum and maximum.
                    if y >= MIN_COORD && y <= MAX_COORD {
                        // A value in range is safe to use when classifying the point.
                        yIsValid = true
                    } else {
                        print("Out of range. Enter a number from -1000 to 1000.")
                    }
                } catch InputError.invalidNumber {
                    print("Invalid entry. Please enter a number, like 3 or -2.5.")
                } catch {
                    print("Unexpected input error: \(error)")
                }
            } else {
                // Without Y there is no coordinate pair to classify.
                inputEnded = true
            }
        }

        // Classify only after both coordinates have passed their range checks.
        if xIsValid && yIsValid && !inputEnded {
            // The origin and axes are boundaries, not part of any quadrant.
            // Check them first so a zero coordinate cannot be mistaken for a quadrant.
            if x == 0 && y == 0 {
                // Both coordinates are zero, which is the single point where the axes meet.
                print("The point is the origin, so it is not in any quadrant.")
            } else if y == 0 {
                // A zero Y value places the point on the horizontal axis.
                print("The point is on the x-axis, so it is not in any quadrant.")
            } else if x == 0 {
                // A zero X value places the point on the vertical axis.
                print("The point is on the y-axis, so it is not in any quadrant.")
            } else if x > 0 && y > 0 {
                // Positive X goes right and positive Y goes up: the upper-right section.
                print("The point is in Quadrant I.")
            } else if x < 0 && y > 0 {
                // Negative X goes left while positive Y stays above the horizontal axis.
                print("The point is in Quadrant II.")
            } else if x < 0 && y < 0 {
                // Both negative values place the point below and left of the origin.
                print("The point is in Quadrant III.")
            } else {
                // With the axes already excluded, the remaining sign pair is (+X, -Y).
                print("The point is in Quadrant IV.")
            }

            // Ask again until the user gives one of the two uppercase choices.
            answer = ""
            while answer != "Y" && answer != "N" && !inputEnded {
                print("Check another point? (Y/N):")

                if let input = readLine() {
                    answer = input
                    if answer != "Y" && answer != "N" {
                        // An unrecognized answer keeps the confirmation loop active.
                        print("Invalid entry. Please enter uppercase Y or N.")
                    }
                } else {
                    // End-of-input stops the outer point loop.
                    inputEnded = true
                }

            }
        }
    }

    print("Goodbye!")
}

main()
