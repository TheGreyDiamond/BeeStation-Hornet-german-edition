import { Fragment } from 'inferno';
import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

const dangerMap = {
  2: {
    color: 'good',
    localStatusText: 'Offline',
  },
  1: {
    color: 'average',
    localStatusText: 'Caution',
  },
  0: {
    color: 'bad',
    localStatusText: 'Optimal',
  },
};

export const AiAirlock = (props, context) => {
  const { act, data } = useBackend(context);
  const statusMain = dangerMap[data.power.main] || dangerMap[0];
  const statusBackup = dangerMap[data.power.backup] || dangerMap[0];
  const statusElectrify = dangerMap[data.shock] || dangerMap[0];
  return (
    <Window
      width={500}
      height={390}>
      <Window.Content>
        <Section title="Power Status">
          <LabeledList>
            <LabeledList.Item
              label="Main"
              color={statusMain.color}
              buttons={(
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.main}
                  content="Disrupt"
                  onClick={() => act('disrupt-main')} />
              )}>
              {data.power.main ? 'Online' : 'Offline'}
              {' '}
              {(!data.wires.main_1 || !data.wires.main_2)
                && '[Die Dr&auml;hte wurden durchgeschnitten!]'
                || (data.power.main_timeleft > 0
                  && `[${data.power.main_timeleft}s]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="Backup"
              color={statusBackup.color}
              buttons={(
                <Button
                  icon="lightbulb-o"
                  disabled={!data.power.backup}
                  content="Disrupt"
                  onClick={() => act('disrupt-backup')} />
              )}>
              {data.power.backup ? 'Online' : 'Offline'}
              {' '}
              {(!data.wires.backup_1 || !data.wires.backup_2)
                && '[Die Dr&auml;hte wurden durchgeschnitten!]'
                || (data.power.backup_timeleft > 0
                  && `[${data.power.backup_timeleft}s]`)}
            </LabeledList.Item>
            <LabeledList.Item
              label="Electrify"
              color={statusElectrify.color}
              buttons={(
                <Fragment>
                  <Button
                    icon="wrench"
                    disabled={!(data.wires.shock && data.shock === 0)}
                    content="Wiederherrstellen"
                    onClick={() => act('shock-restore')} />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="Tempor&auml;r"
                    onClick={() => act('shock-temp')} />
                  <Button
                    icon="bolt"
                    disabled={!data.wires.shock}
                    content="Permanent"
                    onClick={() => act('shock-perm')} />
                </Fragment>
              )}>
              {data.shock === 2 ? 'Sicher' : 'Elektrifiziert'}
              {' '}
              {!data.wires.shock
                && '[Die Dr&auml;hte wurden durchgeschnitten!]'
                || (data.shock_timeleft > 0
                  && `[${data.shock_timeleft}s]`)
                || (data.shock_timeleft === -1
                  && '[Permanent]')}
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Zugang und T&uuml;rkontrolle">
          <LabeledList>
            <LabeledList.Item
              label="ID Scan"
              color="bad"
              buttons={(
                <Button
                  icon={data.id_scanner ? 'power-off' : 'times'}
                  content={data.id_scanner ? 'Aktiviert' : 'Deaktiviert'}
                  selected={data.id_scanner}
                  disabled={!data.wires.id_scanner}
                  onClick={() => act('idscan-toggle')} />
              )}>
              {!data.wires.id_scanner && '[Die Dr&auml;hte wurden durchgeschnitten!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Notfall-Zugang"
              buttons={(
                <Button
                  icon={data.emergency ? 'power-off' : 'times'}
                  content={data.emergency ? 'Aktiviert' : 'Deaktiviert'}
                  selected={data.emergency}
                  onClick={() => act('emergency-toggle')} />
              )} />
            <LabeledList.Divider />
            <LabeledList.Item
              label="T&uuml; Bolzen"
              color="bad"
              buttons={(
                <Button
                  icon={data.locked ? 'lock' : 'unlock'}
                  content={data.locked ? 'Abgesenkt' : 'Hochgezogen'}
                  selected={data.locked}
                  disabled={!data.wires.bolts}
                  onClick={() => act('bolt-toggle')} />
              )}>
              {!data.wires.bolts && '[Die Dr&auml;hte wurden durchgeschnitten!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="T&uuml; Bolzen Leuchten"
              color="bad"
              buttons={(
                <Button
                  icon={data.lights ? 'power-off' : 'times'}
                  content={data.lights ? 'Aktiviert' : 'Deaktiviert'}
                  selected={data.lights}
                  disabled={!data.wires.lights}
                  onClick={() => act('light-toggle')} />
              )}>
              {!data.wires.lights && '[Die Dr&auml;hte wurden durchgeschnitten!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="T&uuml;rkraftsensoren"
              color="bad"
              buttons={(
                <Button
                  icon={data.safe ? 'power-off' : 'times'}
                  content={data.safe ? 'Aktiviert' : 'Deaktiviert'}
                  selected={data.safe}
                  disabled={!data.wires.safe}
                  onClick={() => act('safe-toggle')} />
              )}>
              {!data.wires.safe && '[Die Dr&auml;hte wurden durchgeschnitten!]'}
            </LabeledList.Item>
            <LabeledList.Item
              label="Door Timing Safety"
              color="bad"
              buttons={(
                <Button
                  icon={data.speed ? 'power-off' : 'times'}
                  content={data.speed ? 'Aktiviert' : 'Deaktiviert'}
                  selected={data.speed}
                  disabled={!data.wires.timing}
                  onClick={() => act('speed-toggle')} />
              )}>
              {!data.wires.timing && '[Die Dr&auml;hte wurden durchgeschnitten!]'}
            </LabeledList.Item>
            <LabeledList.Divider />
            <LabeledList.Item
              label="T&uuml;r Kontrolle"
              color="bad"
              buttons={(
                <Button
                  icon={data.opened ? 'sign-out-alt' : 'sign-in-alt'}
                  content={data.opened ? 'Offen' : 'Geschlossen'}
                  selected={data.opened}
                  disabled={(data.locked || data.welded)}
                  onClick={() => act('open-close')} />
              )}>
              {!!(data.locked || data.welded) && (
                <span>
                  [Door is {data.locked ? 'verriegelt' : ''}
                  {(data.locked && data.welded) ? ' und ' : ''}
                  {data.welded ? 'welded' : ''}!]
                </span>
              )}
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
