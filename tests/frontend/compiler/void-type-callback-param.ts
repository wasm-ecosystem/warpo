class VoidCallbackHolder<T> {
  then(cb: (value: T) => void): void {}
}

new VoidCallbackHolder<void>().then(function (): void {});

ERROR("EOF");
