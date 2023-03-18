<?php
if ((bool) getenv('PS_DEV_MODE')) {
    define('_PS_MODE_DEV_', (bool) getenv('PS_DEV_MODE'));
}
// FYI: Defining env var _PS_HOST_MODE_ as true also works natively
if ((bool) getenv('PS_HOST_MODE')) {
    define('_PS_HOST_MODE_', (bool) getenv('PS_HOST_MODE'));
}
