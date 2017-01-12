import qwest from "qwest";
import authenticityToken from "utils/authenticity_token";
import { pickBy, isEmpty, merge } from "lodash";

export function fetchUsers(params) {
  const data = pickBy(params, (v, k) => { return v.toString().length > 0 });
  return (dispatch) => {
    qwest.get(`/users.json`, merge({}, data, { authenticity_token: authenticityToken }))
     .then((xhr, response) => {
        dispatch({ users: response, params: params });
     });
  };
}
