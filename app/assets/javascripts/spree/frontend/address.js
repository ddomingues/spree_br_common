Spree.ready(function ($) {
  'use strict';

  function _in(region) {
    return {
      find: function (selector) {
        return $('#' + region + selector);
      }
    }
  }

  function isPresent(value) {
    return $.trim(value).length
  }

  var $checkoutFormAddress = $('#checkout_form_address');

  if ($checkoutFormAddress.is('*')) {
    var citiesCallbacks = [];

    $checkoutFormAddress.validate();

    Spree.fillAddress = function (region, zipcode) {

      $('.ajax-loading').attr({disabled: true});

      Spree.ajax(Spree.routes.address_show(zipcode))
        .done(function (data) {
          if (isPresent(data.estado)) {

            if (isPresent(data.cidade))
              citiesCallbacks.push(function () {
                var $city = _in(region).find('city select');
                var idCity = $city.find('option:contains("' + data.cidade + '")').val();
                $city.val(idCity);
              });

            var $state = _in(region).find('state select');
            var idState = $state.find('option[data-uf="' + data.estado + '"]').val();
            $state.val(idState).trigger('change');
          }

          _in(region).find('address1 input').val(data.logradouro);
          _in(region).find('district input').val(data.bairro);
        })
        .fail(function () {
          alert('Não foi possível encontrar o CEP especificado, por favor, verifique ou preencha manualmente o cadastro');
        })
        .always(function () {
          $('.ajax-loading').attr({disabled: false});
        });
    };

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

        while (citiesCallbacks.length) {
          citiesCallbacks.pop()();
        }
      }
    };

    $(['b', 's']).each(function (i, region) {
      function onChangeUpdateAddress() {
        return Spree.fillAddress(region, $(this).cleanVal());
      }

      function onChangeUpdateCity() {
        return Spree.updateCity(region);
      }

      _in(region).find('state select').on('change', onChangeUpdateCity);
      _in(region).find('zipcode input').on('change', onChangeUpdateAddress);
    });
  }
});