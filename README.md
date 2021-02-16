# RANDOMTransport

> A useless app that sends you around Switzerland and wastes your time.
---
## What is it?

This project is essentially an abuse of the [swiss opendata transport api](https://transport.opendata.ch/). Given a starting station, it will send you around Switzerland randomly, by tellling you what connections to take, and how far to take them. After the given amount of changes have occured, it ends. Congratulations, you win nothing.

## Development
I strongly recommend using the flutter beta branch to debug on chrome, rather than on emulator.

## Contribute.
Please choose one of the open issues and assign yourself. You can then fork this repo and open a pull request with your feature. Since I am lazy, there is no test coverage and no CI/CD, so just hope it works, ig?

## Roadmap
- ~~Limit amount of rerolls based on slider input -> Provider?~~
- Implement error handling on network issues
- Fix failed assertion if station does not exist
- ~~Timestamp parsing is still wrong~~
- UI implementation for endnodes in list
- Implement endview
- Implement geolocation for starting station
- Fix horizontal overflow in list
- It is possible for the route to be empty!!!