Spree.ready(function() {
  'use strict';

  $('*[data-mask]').each(function() {
    var input = $(this);
    input.mask(input.attr('data-mask'));
  });

  $('*[type="tel"]').mask(
    PhoneMaskBehavior,
    {
      onKeyPress: function(val, e, field, options) {
        field.mask(PhoneMaskBehavior(val, e, field, options), options);
      }
    }
  );
});