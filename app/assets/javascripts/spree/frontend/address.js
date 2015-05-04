Spree.ready(function ($) {
  'use strict';

  function _in(region) {
    return {
      find: function (selector) {
        return $('#' + region + selector);
      }
    }
  }

  var $checkoutFormAddress = $('#checkout_form_address');

  if ($checkoutFormAddress.is('*')) {
    var citieCallbacks = [];

    $checkoutFormAddress.validate();

    Spree.getStateId = function (region) {
      return _in(region).find('state select').val();
    };

    Spree.updateCity = function (region) {
      var stateId = Spree.getStateId(region);
      if (stateId !== '') {
        if (!Spree.Checkout[stateId] || !Spree.Checkout[stateId].cities) {
          return Spree.ajax(
            Spree.routes.cities_search,
            {
              data: {state_id: stateId},
              success: function (data) {
                Spree.Checkout[stateId] = data;
                Spree.fillCities(Spree.Checkout[stateId].cities, region);
              }
            }
          );
        } else {
          return Spree.fillCities(Spree.Checkout[stateId].cities, region);
        }
      }
    };

    Spree.fillCities = function (cities, region) {
      var selected,
        optionsCities = [],
        citySelect = _in(region).find('city select');

      citySelect.html('');

      if (cities.length > 0) {
        selected = parseInt(citySelect.val());

        $.each(cities, function (idx, city) {

          var $option = $('<option />').attr('value', city.id).html(city.name);

          if (selected === city.id)
            $option.prop('selected', true);

          optionsCities.push($option);
        });

        citySelect.append(optionsCities);

        while(citieCallbacks.length) {
          citieCallbacks.pop()();
        }
      }
    };

    $(['b', 's']).each(function (i, region) {
      _in(region).find('state select').on('change', function () {
        return Spree.updateCity(region);
      });
    })
  }
});