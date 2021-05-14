BonkLink

Brent Dunbar
Guy Greenleaf
Jacques Sarraffe
Jessica Wood

A modern-day chat application that uses the serverless database Realm as an architecture and implements a number of features including instant messaging via text, photo, and other media.  The app also gives the user the ability to share their location as well as set reminders to ping their mobile device at a set time interval between 1 and 24 hours.

The app has an entry point titled BonkLinkApp.swift and uses two Swift Package Dependencies: Realm and RealmDatabase
These dependencies should install automatically, but incase they do not, the link to the github that you can point the Swift Package Manager is as follows:https://github.com/realm/realm-cocoa

This app was built using Models and Realms that work together in sync and use RealmSync to accomplish the problem of real-time data transfer and retrieval.Because the app is built on the backbone of a serverless architecture, offline data reads/writes are possible and all data is eventually synced across every device upon reconnection.  One downside to this, of course, is the volume of data that can be transferred upon reconnection can become incredibly large depending on the length of the downtime, thus causing minor slowdowns if specific higher-tiered plans are not paid for. 



