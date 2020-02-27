import { createStore, applyMiddleware } from "redux";
import reducer from "./reducers";
import thunk from "redux-thunk";

const configureStore = preloadedState => createStore(reducer, preloadedState, applyMiddleware(thunk));

export default configureStore;
