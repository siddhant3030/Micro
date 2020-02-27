import React from "react";
import { render } from "react-dom";
import { Provider } from "react-redux";
import { BrowserRouter } from "react-router-dom";
import App from "../shared/App";
import configureStore from "../shared/configureStore";
import * as serviceWorker from "../../serviceWorker";

const store = configureStore(window.__initialData__);

delete window.__initialData__;

render(
  <Provider store={store}>
    <BrowserRouter>
      <App />
    </BrowserRouter>
  </Provider>,
  document.getElementById("root")
);

// serviceWorker.register();
