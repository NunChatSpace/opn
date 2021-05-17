defmodule Reborn.GatewayPlug do
    import Plug.Conn

    def init(options), do: options

    def call(conn, _opts) do
      data = FastGlobal.get(:data)
      cond do
          data == nil ->
            FastGlobal.put(:data, 0)
          data != nil ->
            FastGlobal.put(:data, data + 1)
          end
      IO.inspect """
      Page hit count is #{FastGlobal.get(:data)}
      """
      conn
    end

    # params: %{"page" => "home"}, path_info: ["dashboard", "home"], path_params: %{"page" => "home"},
end