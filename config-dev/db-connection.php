<?php

return new PDO("mysql:host=db;dbname=sample", "sampleuser", "samplepass", [PDO::ATTR_PERSISTENT => true]);
