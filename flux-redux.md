#Flux - Redux
- Redux in one implementation of the flux specification

##What is Redux
- All application state is kept in a single **Store**
- State is READONLY
- State can be updated by dispatching actions
- Actions are plain javascript objects
- State is mutated functionally via Reducers
- Subscribers are notified of changes only to their specific slice of the state

##What it has
- One way data flow
- Update state with dispatched actions
- Subscribed components re-render on changes to their slice
- Redux manages the broadcast of state changes

