package ru.kpfu.itis.kulsidv.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class ExceptionLoggingAspect {
    private static final Logger LOG = LoggerFactory.getLogger(ExceptionLoggingAspect.class);

    @Pointcut("@annotation(ExceptionLoggable)")
    public void exceptionLoggableMethod() {}

    @Around("exceptionLoggableMethod()")
    public Object logException(ProceedingJoinPoint joinPoint) throws Throwable {
        try {
            return joinPoint.proceed();
        } catch (Exception e) {
            String methodName = joinPoint.getSignature().getName();
            String className = joinPoint.getTarget().getClass().getSimpleName();
            LOG.error("Exception in {}.{}(): {}", className, methodName, e.getMessage(), e);
            throw e;
        }
    }
}