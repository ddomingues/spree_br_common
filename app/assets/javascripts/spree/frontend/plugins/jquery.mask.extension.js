function PhoneMaskBehavior (val, e, field, options) {
  var masks = ['(00) 00000-0000', '(00) 0000-00009'];
  return val.length > 14 ? masks[0] : masks[1];
};