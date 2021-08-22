import 'jquery.repeatable'

import './anything_form'
import { initDynamicElements, customDynamicElement } from '../../lib/dynamicElements'

initDynamicElements();

window.customDynamicElement = customDynamicElement;
