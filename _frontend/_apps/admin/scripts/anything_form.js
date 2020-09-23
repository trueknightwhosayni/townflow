import { removeWithAnimation } from '../../helpers/animations'

$(document).ready(function() {
  $('body').on('click', 'a.remove-anything-form-field', function(e) {
    e.preventDefault();
    e.stopPropagation();
    if (confirm($(this).data('confirm'))) {
      removeWithAnimation($(this).closest('.field_row'));
    }
  });

  $('body').on('click', 'a.remove-anything-form-field-validation', function(e) {
    e.preventDefault();
    e.stopPropagation();
    if (confirm($(this).data('confirm'))) {
      removeWithAnimation($(this).closest('.validation_row'));
    }
  });

  /* START FIELD ROWS */

  const initializeField = function(field_row) {
    const fieldId = field_row.attr('id').replace("field-", "");

    field_row.find(".validations-container").repeatable({
      template: "#validation-row",
      addTrigger: `#add-validation-button-${fieldId}`,
      itemContainer: ".validation_row",
      afterAdd: function(validation_row) {
        const correctValidationId = validation_row.attr('id').replace("field_index_placeholder", fieldId)
        validation_row.attr('id', correctValidationId)

        const allowBlankCheckbox = validation_row.find('.allow-blank-checkbox')
        const allowBlankLabel = validation_row.find('.allow-blank-label')

        const checkboxId = allowBlankCheckbox.attr('id')
        const newCheckboxId = checkboxId.replace("field_index_placeholder", fieldId)

        allowBlankCheckbox.attr('id', newCheckboxId);
        allowBlankLabel.attr('for',   newCheckboxId);
      }
    });
  }

  if ($("form .fields-container").length) {
    $("form .field_row").each(function() {
      initializeField($(this))
    })

    $("form .fields-container").repeatable({
      template: "#field-row",
      addTrigger: "#add-field-button",
      itemContainer: ".field_row",
      afterAdd: initializeField
    });
  }

  /* END FIELD ROWS */

  /* START DYNAMIC FIELD COMPONENTS */

  $('body').on('change', 'select.field_type', function(e) {
    const selectInput = e.target
    const scriptUrl = $('#form_helper_script').data('url')

    const fieldId = $(selectInput).closest('.field_row').attr('id');

    const req = {
      url: scriptUrl,
      dataType: "script",
      data: {
        component: 'field_type',
        field_id: fieldId,
        field_type: selectInput.value
      },
      success: function() {}
    }

    jQuery.ajax(req);
  })

  /* END DYNAMIC FIELD COMPONENTS */

  /* START DYNAMIC VALIDATION COMPONENTS */

  $('body').on('change', 'select.validation_type', function(e) {
    const selectInput = e.target
    const scriptUrl = $('#form_helper_script').data('url')

    const validationId = $(selectInput).closest('.validation_row').attr('id');

    const req = {
      url: scriptUrl,
      dataType: "script",
      data: {
        component: 'validation',
        validation_id: validationId,
        validation: selectInput.value
      },
      success: function() {}
    }

    jQuery.ajax(req);
  })

  /* END DYNAMIC VALIDATION COMPONENTS */
})