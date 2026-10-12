class UnusedValue {
  details: Details = new Details();
}

class Details {
  value: bool;
}

class Settings {
  unused: UnusedValue = new UnusedValue();
}

function createSettings(): Settings {
  const settings = new Settings();
  const unused = settings.unused;
  const details = unused.details;
  details.value = true;
  return settings;
}

assert(createSettings() != null);
