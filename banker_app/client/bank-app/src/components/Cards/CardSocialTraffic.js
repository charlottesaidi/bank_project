import React from "react";

// components

export default function CardSocialTraffic({props}) {
  let negative_accounts = [];

  props.forEach((el) => {
    if(el.accounts?.[0]?.balance < 0 || el.accounts?.[1]?.balance < 0 || el.accounts?.[2]?.balance < 0) {
      negative_accounts.push(el)
    }
  })

  function overdraftPercentage(balance, overdraft) {
    return Math.round((balance*100)/overdraft);
  }
  return (
    <>
      <div className="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-lg rounded">
        <div className="rounded-t mb-0 px-4 py-3 border-0">
          <div className="flex flex-wrap items-center">
            <div className="relative w-full px-4 max-w-full flex-grow flex-1">
              <h3 className="font-semibold text-base text-blueGray-700">
                Soldes Négatifs
              </h3>
            </div>
            <div className="relative w-full px-4 max-w-full flex-grow flex-1 text-right">
              <button
                className="bg-indigo-500 text-white active:bg-indigo-600 text-xs font-bold uppercase px-3 py-1 rounded outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                type="button"
              >
                voir plus
              </button>
            </div>
          </div>
        </div>
        <div className="block w-full overflow-x-auto">
          {/* Projects table */}
          <table className="items-center w-full bg-transparent border-collapse">
            <thead className="thead-light">
              <tr>
                <th className="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                  Clients
                </th>
                <th className="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left min-w-140-px">
                  Comptes
                </th>
                <th className="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                  soldes
                </th>
                <th className="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left min-w-140-px">
                  Découvert utilisé
                </th>
              </tr>
            </thead>
            <tbody>
              {Array.from(negative_accounts).map(
                (item, index) => (
                  (
                    <tr key={index}>
                      <th className="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left">
                        {item.user.last_name} {item.user.first_name}
                      </th>
                      <td className="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                        {Array.from(item.accounts).map((el, index) => (
                          (
                            <p key={index}>{el.balance < 0 && el.hashid}</p>
                          )
                        )
                      )}
                      </td>
                      <td className="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                        {Array.from(item.accounts).map((el, index) => (
                          (
                            <p key={index}>{el.balance < 0 && el.balance + " €"}</p>
                          )
                        )
                      )}
                      </td>
                      <td className="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                        {Array.from(item.accounts).map((el, index) => (
                          (
                            <div key={index}>
                              {el.balance < 0 && 
                                <div className="flex items-center">
                                  <span className="mr-2">{overdraftPercentage(el.balance, el.overdraft) + "%"}</span>
                                  <div className="relative w-full">
                                    <div className="overflow-hidden h-2 text-xs flex rounded bg-red-200">
                                      <div
                                        style={{ width: overdraftPercentage(el.balance, el.overdraft)+"%" }}
                                        className="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center bg-red-500"
                                      ></div>
                                    </div>
                                  </div>
                                </div>
                              }
                            </div>
                          )
                        )
                      )}
                      </td>
                    </tr>
                  )
                )
              )}
            </tbody>
          </table>
        </div>
      </div>
    </>
  );
}
