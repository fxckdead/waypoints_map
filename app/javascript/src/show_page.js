import { DateTime } from "luxon";
import mapboxgl from "mapbox-gl";
mapboxgl.accessToken =
  "pk.eyJ1Ijoic3RheXRydWVjbCIsImEiOiJja2FjN3F5bXEwMTk2MnlvNjBncDh1bTI2In0.-R60rCLTCklhTfY9CqPnAA";

var mapInstance;

const loadPoints = () => {
  if (!mapInstance) {
    return;
  }

  VEHICLES.forEach((vehicle) => {
    if (!vehicle.latitude || !vehicle.longitude) {
      return;
    }

    const sent_at = DateTime.fromISO(vehicle.sent_at);
    const el = document.createElement("img");
    el.src = BEE_URL;

    const marker = new mapboxgl.Marker(el)
      .setLngLat([vehicle.longitude, vehicle.latitude])
      .setPopup(
        new mapboxgl.Popup({ offset: 25 }).setHTML(
          `<h3>Vehicle: ${
            vehicle.identifier
          }</h3><p>Sent At: ${sent_at.toLocaleString(
            DateTime.DATETIME_MED
          )}</p>`
        )
      )
      .addTo(mapInstance);
  });
};

const handleLinkClick = (e) => {
  const id = e.target.getAttribute("data-id");
  const vehicle = VEHICLES.find((v) => v.vehicle_id.toString() === id);
  if (!vehicle || !vehicle.latitude || !vehicle.longitude) {
    return;
  }

  mapInstance.flyTo({
    center: [vehicle.longitude, vehicle.latitude],
    zoom: 15,
  });
};

const bindLinksClick = () => {
  const elements = document.getElementsByClassName("link-vehicle");

  Array.from(elements).forEach(element => {
    element.addEventListener("click", handleLinkClick);
  });
};

// avoid jQuery...
document.addEventListener("DOMContentLoaded", () => {
  mapInstance = new mapboxgl.Map({
    container: "map",
    style: "mapbox://styles/mapbox/dark-v10",
    zoom: 8,
    center: [-70.5739411, -33.4094272],
  }).addControl(new mapboxgl.NavigationControl({ showCompass: false }));

  mapInstance.on("load", () => {
    const coordinates = VEHICLES.map((v) => [v.longitude, v.latitude]);
    const bounds = coordinates.reduce((bounds, coord) => {
      return bounds.extend(coord);
    }, new mapboxgl.LngLatBounds(coordinates[0], coordinates[0]));

    mapInstance.fitBounds(bounds, {
      padding: { top: 0, bottom: 0, left: 80, right: 80 },
    });
  });

  loadPoints();
  bindLinksClick();
});
