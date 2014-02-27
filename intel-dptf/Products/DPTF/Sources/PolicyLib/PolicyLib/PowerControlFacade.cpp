/******************************************************************************
** Copyright (c) 2014 Intel Corporation All Rights Reserved
**
** Licensed under the Apache License, Version 2.0 (the "License"); you may not
** use this file except in compliance with the License.
**
** You may obtain a copy of the License at
**     http://www.apache.org/licenses/LICENSE-2.0
**
** Unless required by applicable law or agreed to in writing, software
** distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
** WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
**
** See the License for the specific language governing permissions and
** limitations under the License.
**
******************************************************************************/

#include "PowerControlFacade.h"
using namespace std;

PowerControlFacade::PowerControlFacade(
    UIntN participantIndex,
    UIntN domainIndex,
    const DomainProperties& domainProperties,
    const PolicyServicesInterfaceContainer& policyServices)
    : m_participantIndex(participantIndex),
    m_domainIndex(domainIndex),
    m_domainProperties(domainProperties),
    m_policyServices(policyServices),
    m_powerControlSetProperty(participantIndex, domainIndex, domainProperties, policyServices),
    m_powerStatusProperty(participantIndex, domainIndex, domainProperties, policyServices),
    m_powerControlCapabilitiesProperty(participantIndex, domainIndex, domainProperties, policyServices),
    m_controlsHaveBeenInitialized(false)
{
}

PowerControlFacade::~PowerControlFacade()
{
}

Bool PowerControlFacade::supportsPowerControls(void)
{
    return m_domainProperties.implementsPowerControlInterface();
}

const PowerStatus& PowerControlFacade::getStatus(void)
{
    return m_powerStatusProperty.getStatus();
}

void PowerControlFacade::setControl(const PowerControlStatus& powerControlStatus, UIntN controlSetIndex)
{
    if (supportsPowerControls())
    {
        vector<PowerControlStatus> powerControlList;
        PowerControlStatusSet currentSet = getControls();
        UIntN setSize = currentSet.getCount();
        for (UIntN setIndex = 0; setIndex < setSize; setIndex++)
        {
            if (setIndex == controlSetIndex)
            {
                powerControlList.push_back(powerControlStatus);
            }
            else
            {
                powerControlList.push_back(currentSet[setIndex]);
            }
        }

        m_policyServices.domainPowerControl->setPowerControl(
            m_participantIndex, m_domainIndex, PowerControlStatusSet(powerControlList));
        m_powerStatusProperty.invalidate();
        m_powerControlSetProperty.invalidate();
    }
    else
    {
        throw dptf_exception("Domain does not support the power control interface.");
    }
}

const PowerControlStatusSet& PowerControlFacade::getControls()
{
    initializeControlsIfNeeded();
    return m_powerControlSetProperty.getControlSet();
}

void PowerControlFacade::refreshControls()
{
    m_powerControlSetProperty.refresh();
    m_powerStatusProperty.invalidate();
}

void PowerControlFacade::refreshStatus()
{
    m_powerStatusProperty.refresh();
}

void PowerControlFacade::invalidateStatus()
{
    m_powerStatusProperty.invalidate();
}

void PowerControlFacade::refreshCapabilities()
{
    m_powerControlCapabilitiesProperty.refresh();
}

const PowerControlDynamicCapsSet& PowerControlFacade::getCapabilities()
{
    return m_powerControlCapabilitiesProperty.getDynamicCapsSet();
}

UIntN PowerControlFacade::getPl1ControlSetIndex()
{
    const PowerControlDynamicCapsSet& capsSet = getCapabilities();
    for (UIntN setIndex = 0; setIndex < capsSet.getCount(); setIndex++)
    {
        if (capsSet[setIndex].getPowerControlType() == PowerControlType::pl1)
        {
            return setIndex;
        }
    }
    throw dptf_exception("Power control set does not contain an entry for PL1.");
}

UIntN PowerControlFacade::getPlControlSetIndex(PowerControlType::Type plType)
{
    const PowerControlDynamicCapsSet& capsSet = getCapabilities();
    for (UIntN setIndex = 0; setIndex < capsSet.getCount(); setIndex++)
    {
        if (capsSet[setIndex].getPowerControlType() == plType)
        {
            return setIndex;
        }
    }
    throw dptf_exception("Power control set does not contain an entry for PL Type.");
}

void PowerControlFacade::initializeControlsIfNeeded()
{
    if (m_controlsHaveBeenInitialized == false)
    {
        vector<PowerControlStatus> initialStatusList;
        const PowerControlDynamicCapsSet& caps = getCapabilities();
        for (UIntN capIndex = 0; capIndex < caps.getCount(); ++capIndex)
        {
            initialStatusList.push_back(
                PowerControlStatus(
                    caps[capIndex].getPowerControlType(),
                    caps[capIndex].getMaxPowerLimit(),
                    caps[capIndex].getMaxTimeWindow(),
                    caps[capIndex].getMaxDutyCycle()));
        }
        m_policyServices.domainPowerControl->setPowerControl(
            m_participantIndex, m_domainIndex, PowerControlStatusSet(initialStatusList));
        m_controlsHaveBeenInitialized = true;
    }
}