#
# This file is part of Astarte.
#
# Copyright 2025 SECO Mind Srl
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
defmodule Astarte.DataAccess.Generators.Interface do
  @moduledoc """
  This module provides generators for Astarte.DataAccess.Interface.
  """
  use ExUnitProperties

  alias Astarte.Core.Interface

  alias Astarte.DataAccess.Realms.Endpoint, as: MappingData
  alias Astarte.DataAccess.Realms.Interface, as: InterfaceData

  alias Astarte.DataAccess.Generators.Mapping, as: MappingDataGenerators

  @type package :: {InterfaceData.t(), list(MappingData.t())}

  @doc """
  Map the core generator to a data_access one
  """
  @spec from_core(StreamData.t(Interface.t())) :: StreamData.t(package())
  def from_core(gen) do
    gen all(
          %Interface{
            interface_id: interface_id,
            name: name,
            major_version: major_version,
            minor_version: minor_version,
            type: type,
            ownership: ownership,
            aggregation: aggregation,
            mappings: mappings
          } <- gen,
          storage <- storage(),
          mappings <-
            mappings
            |> Enum.map(&MappingDataGenerators.from_core(constant(&1)))
            |> fixed_list()
        ) do
      {%InterfaceData{
         interface_id: interface_id,
         name: name,
         major_version: major_version,
         minor_version: minor_version,
         aggregation: aggregation,
         ownership: ownership,
         type: type,
         storage: storage
       }, mappings}
    end
  end

  defp storage, do: string([?a..?z, ?0..?9, ?_], min_length: 1)
end
