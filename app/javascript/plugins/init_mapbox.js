import mapboxgl from 'mapbox-gl';

const buildMap = (mapElement) => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/j35/ckol044kx816317qen4cgfg3v'
  });
};

let markerCount = 1;

const addMarkersToMap = (map, markers) => {

  const firstMarker = markers[0]

  const firstElement = document.createElement('div');
  firstElement.className = 'marker';
  // add an ID
  //firstElement.className = 'marker';

  firstElement.style.backgroundImage = `url('${firstMarker.image_url}')`;
  firstElement.style.backgroundSize = 'contain';
  firstElement.style.backgroundRepeat = 'no-repeat';
  firstElement.style.width = '40px';
  firstElement.style.height = '48px';
  firstElement.dataset.controller = 'city';
  firstElement.dataset.action = 'click->city#show';
  firstElement.dataset.cityTarget= 'marker';
  firstElement.dataset.id = firstMarker.id;

  new mapboxgl.Marker(firstElement)
    .setLngLat([ firstMarker.lng, firstMarker.lat ])
    .addTo(map);

  markers.slice(1, -1).forEach((marker) => {

    const element = document.createElement('div');
    element.className = `marker marker${markerCount}`;
    element.style.backgroundImage = `url('${marker.image_url}')`;
    element.style.backgroundSize = 'contain';
    element.style.backgroundRepeat = 'no-repeat';
    element.style.width = '24px';
    element.style.height = '32px';
    element.dataset.controller = 'city';
    element.dataset.action = 'click->city#show';
    element.dataset.cityTarget= 'marker';
    element.dataset.id = marker.id;

    markerCount ++;

    new mapboxgl.Marker(element)
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) {
    const map = buildMap(mapElement);
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};



export { initMapbox };
