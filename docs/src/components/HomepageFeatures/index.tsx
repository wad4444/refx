import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<'svg'>>;
  description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
  {
    title: 'Easy to Use',
    Svg: require('@site/static/img/plug.svg').default,
    description: (
      <>
        Refx is very easy to understand and use, as it exports only 4 functions for the user.
      </>
    ),
  },
  {
    title: 'Lightweight',
    Svg: require('@site/static/img/settings.svg').default,
    description: (
      <>
        Refx is a lightweight library containing under 500 lines of code, designed with simplicity and flexibility in mind.
      </>
    ),
  },
  {
    title: 'Modular',
    Svg: require('@site/static/img/wires.svg').default,
    description: (
      <>
        Refx keeps your visual effects code modular and easy to manipulate.
      </>
    ),
  },
];

function Feature({title, Svg, description}: FeatureItem) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
