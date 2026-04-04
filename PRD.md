# Product Requirements Document: SoHot Weather App

**Version:** 1.0
**Status:** Completed
**Author:** Stitch (Design Partner)

---

## 1. Executive Summary
SoHot is a minimalist mobile weather application designed for users who want immediate, glanceable access to their local weather conditions without the clutter of traditional weather apps. The focus is on three core data points: location (sub-district), temperature, and "feels like" conditions.

---

## 2. Problem Statement
Many weather apps are overloaded with complex charts, hourly forecasts, and radar maps that overwhelm users who simply want to know the current temperature and how it feels outside before stepping out. SoHot solves this by stripping away the noise and providing a high-fidelity, focused experience.

---

## 3. Goals & Objectives
*   **Goal:** Provide the fastest way to check essential local weather.
*   **Objective:** Achieve a sub-2 second load time for core weather data.
*   **Objective:** Maintain a 100% focused UI with zero secondary navigation on the main dashboard.

---

## 4. Target Audience
*   **The "Glance-and-Go" User:** Individuals who check their phone quickly before leaving for work or errands.
*   **Minimalists:** Users who prefer clean, ethereal aesthetics over data-dense interfaces.

---

## 5. Solution Overview
A single-screen mobile application using high-contrast typography and a soft gradient background to communicate weather status through both data and visual mood.

---

## 6. Key Features & Functionality

### 6.1. Core Weather Display
*   **Location:** Automatically detects and displays the user's sub-district name (e.g., "Upper West Side").
*   **Primary Temperature:** Large, bold display of the current temperature.
*   **Default Unit:** Celsius (°C).
*   **"Feels Like" Temperature:** Displayed prominently below the main temperature.
*   **Weather Status:** Text description of current conditions (e.g., "Partly Cloudy").

### 6.2. Interactive Unit Toggle
*   **Feature:** A single, highlighted 'F' letter icon located next to the primary temperature.
*   **Interaction:** Tapping the 'F' switches the entire app's temperature display to Fahrenheit.

### 6.3. Weather Details Cards
*   **Wind Speed:** Displayed in **kilometers per hour (km/h)** by default.
*   **Humidity:** Displayed as a percentage.
*   **Wind Direction:** Displayed via cardinal directions (e.g., WNW).

### 6.4. System UI Integration
*   **Status Bar:** Standard mobile status bar visible at all times to show the current system time, battery, and connectivity.

---

## 7. User Experience (UX) & Design
*   **Design System:** SoHot Mono (Ethereal Observer).
*   **Color Palette:** Soft blue gradients (#7CB9E8) transitioning to white, creating a "sky" effect.
*   **Typography:** Manrope for a modern, geometric feel with high legibility.
*   **Shape:** Rounded corners (Round 8) on cards to maintain a soft, approachable aesthetic.

---

## 8. Technical Requirements
*   **Geolocation:** Requires permission to access high-accuracy device location.
*   **Weather API:** Integration with a real-time weather data provider (e.g., OpenWeatherMap or Apple WeatherKit).
*   **State Management:** Must persist the user's temperature unit preference (C/F) across sessions.

---

## 9. Out of Scope
*   Hourly forecasts.
*   7-day outlooks.
*   Interactive radar or precipitation maps.
*   Multi-city management (Phase 1 is current location only).
