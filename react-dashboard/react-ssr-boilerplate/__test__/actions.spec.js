import configureMockStore from "redux-mock-store";
import thunk from "redux-thunk";
import { mostViewedProducts } from "../src/shared/actions";

const mostViewedProductSample = require("./mostViewed.data.json");
const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
let store;

describe("action creators", () => {
  describe("most viewed items action creator", () => {
    beforeEach(async () => {
      store = mockStore({ mostViewedProducts: [] });
      await store.dispatch(mostViewedProducts());
    });

    test("should check 'FETCH_MOST_VIEWED_PRODUCTS' action type is returned", () => {
      const expectedActionType = "FETCH_MOST_VIEWED_PRODUCTS";
      return store.dispatch(mostViewedProducts()).then(() => {
        expect(store.getActions()[0].type).toEqual(expectedActionType);
      });
    });

    // test("should fetch action type and payload with data", () => {
    //   const expectedAction = [
    //     {
    //       type: "FETCH_MOST_VIEWED_PRODUCTS",
    //       payload: mostViewedProductSample
    //     }
    //   ];
    //   expect(store.getActions()).toEqual(expectedAction);
    // });

    test("payload object count to be 10", () => {
      expect(store.getActions()[0].payload.length).toEqual(10);
    });

    test("payload to have desired property", () => {
      const payload = store.getActions()[0].payload[0];

      expect(payload).toHaveProperty("sku");
      expect(payload).toHaveProperty("descriptions.short");
      expect(payload).toHaveProperty("customerReviews");
      expect(payload).toHaveProperty("customerReviews.averageScore");
      expect(payload).toHaveProperty("customerReviews.count");
      expect(payload).toHaveProperty("images");
      expect(payload).toHaveProperty("images.standard");
      expect(payload).toHaveProperty("names");
      expect(payload).toHaveProperty("names.title");
      expect(payload).toHaveProperty("prices");
      expect(payload).toHaveProperty("prices.regular");
      expect(payload).toHaveProperty("prices.current");
    });
  });
});
