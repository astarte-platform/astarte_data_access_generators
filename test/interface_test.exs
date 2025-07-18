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

defmodule Astarte.DataAccess.Generators.InterfaceTest do
  @moduledoc """
  Tests for Astarte Interface generator.
  """
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Astarte.DataAccess.Realms.Endpoint, as: MappingData
  alias Astarte.DataAccess.Realms.Interface, as: InterfaceData

  alias Astarte.Core.Generators.Interface, as: InterfaceGenerator
  alias Astarte.DataAccess.Generators.Interface, as: InterfaceDataGenerator

  @moduletag :interface

  @doc false
  describe "interface from_core/1" do
    @describetag :success
    @describetag :ut

    property "check types" do
      check all(
              {interface, mappings} <-
                InterfaceGenerator.interface() |> InterfaceDataGenerator.from_core()
            ) do
        assert is_struct(interface, InterfaceData)
        assert Enum.all?(mappings, &is_struct(&1, MappingData))
      end
    end
  end
end
