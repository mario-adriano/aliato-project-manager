const CACHE_NAME = "offline-cache-v1";
const OFFLINE_URL = "offline.html";

self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll([OFFLINE_URL]);
    })
  );
  self.skipWaiting();
});

// self.addEventListener("install", (event) => {
//   event.waitUntil(
//     caches.open(CACHE_NAME).then((cache) => {
//       return cache.addAll(new Request(OFFLINE_URL, {cache: "reload"}));
//     })
//   );
//   self.skipWaiting();
// });

self.addEventListener("activate", (event) => {
  event.waitUntil(
    Promise.resolve().then(() => {
      if (self.registration.navigationPreload) {
        return self.registration.navigationPreload.enable();
      }
    })
  );
  self.clients.claim();
})

self.addEventListener("fetch", (event) => {
  event.respondWith(
    event.preloadResponse.then((preloadResponse) => {
      if (preloadResponse) {
        return preloadResponse;
      }
      return fetch(event.request)
    }).catch( async (error) => {
      console.log("Failed to fetch the request, serving offline page instead.", error);

      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(OFFLINE_URL);
      })
    })
  )
})
// Add a service worker for processing Web Push notifications:
//
// self.addEventListener("push", async (event) => {
//   const { title, options } = await event.data.json()
//   event.waitUntil(self.registration.showNotification(title, options))
// })
//
// self.addEventListener("notificationclick", function(event) {
//   event.notification.close()
//   event.waitUntil(
//     clients.matchAll({ type: "window" }).then((clientList) => {
//       for (let i = 0; i < clientList.length; i++) {
//         let client = clientList[i]
//         let clientPath = (new URL(client.url)).pathname
//
//         if (clientPath == event.notification.data.path && "focus" in client) {
//           return client.focus()
//         }
//       }
//
//       if (clients.openWindow) {
//         return clients.openWindow(event.notification.data.path)
//       }
//     })
//   )
// })
