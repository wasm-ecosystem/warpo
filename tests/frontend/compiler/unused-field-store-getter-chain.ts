class UnusedValue {
  details: Details = new Details();
}

class Details {
  value: bool;
}

class Settings {
  unused: UnusedValue = new UnusedValue();
}

function initializeSettings(settings: Settings, unused: UnusedValue): void {
  settings.unused = unused;
  const temporaryUnused = settings.unused;
  const details = temporaryUnused.details;
  details.value = true;
}

const settings = new Settings();
initializeSettings(settings, new UnusedValue());
assert(settings != null);
