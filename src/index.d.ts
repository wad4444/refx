/* eslint-disable @typescript-eslint/no-explicit-any */
import type Signal from "@rbxts/signal";

export declare abstract class BaseEffect<T extends unknown[] = []> {
	public readonly Destroyed: Signal<() => void>;
	public readonly IsDestroyed: boolean;

	protected DestroyOnEnd: boolean;
	protected DestroyOnLifecycleEnd: boolean;
	protected MaxLifetime: number;
	protected DisableLeakWarning: boolean;

	constructor(...args: T);

	Start(players?: Player[]): this;
	GetPlayers(): Player[];
	Destroy(): this;

	protected readonly Configuration: T;
	protected OnStart(...args: T): void;
	protected OnConstruct(...args: T): void;
	protected OnDestroy(): void;
}

type Constructor<T> = new (...args: never[]) => T;

export interface FunctionAttributes {
	Unreliable: boolean;
}

export declare function VisualEffectDecorator<T extends Constructor<BaseEffect<any[]>>>(ctor: T): T;
export declare function Config(
	attributes: Partial<FunctionAttributes>,
): <T extends BaseEffect<any[]>>(ctor: T, methodName: string) => void;

export declare function Register(directory: Instance): void;
export declare function Start(): void;

export as namespace Refx;